#!/usr/bin/env python3

import os
import glob

def get_package_type(content):
    for line in content.splitlines():
        if line.startswith('PACKAGE_TYPE='):
            return line.split('=')[1].strip('"\'')
    return 'unknown'

def read_package_scripts():
    packages = []
    for script in glob.glob('scripts/packages/*.sh'):
        with open(script) as f:
            content = f.read()
            packages.append({
                'name': os.path.basename(script).replace('.sh', ''),
                'content': content,
                'type': get_package_type(content)
            })
    return packages

def generate_dockerfile():
    with open('templates/dockerfile.template') as f:
        template = f.read()
    
    packages = read_package_scripts()
    install_commands = []
    
    # Add common.sh which contains helper functions first
    install_commands = ['COPY scripts/common.sh /opt/']
    
    # Add essentials.sh separately
    install_commands.append('COPY scripts/essentials.sh /opt/')
    
    # Add package scripts
    for pkg in packages:
        script_name = f"{pkg['name']}.sh"
        install_commands.append(f'COPY scripts/packages/{script_name} /opt/packages/')
    
    # Source common.sh and run essentials first
    install_commands.extend([
        'RUN source /opt/common.sh && \\',
        '    source /opt/essentials.sh && \\',
        '    install && \\',
        '    test || echo "Failed to install essentials" && \\'
    ])
    
    # Now add the installation commands for other packages
    for pkg in packages:
        install_commands.extend([
            f'    source /opt/packages/{pkg["name"]}.sh && \\',
            f'    install && \\',
            f'    test || echo "Failed to install {pkg["name"]}"' + (' && \\' if pkg != packages[-1] else '')
        ])
    
    return template.replace('{{INSTALL_COMMANDS}}', '\n'.join(install_commands))

def generate_install_script():
    with open('templates/install.template') as f:
        template = f.read()
    
    packages = read_package_scripts()
    install_commands = []  # Remove essentials since it's handled separately
    
    for pkg in packages:
        install_commands.extend([
            f'source scripts/packages/{pkg["name"]}.sh',
            'install',
            f'test || echo "Failed to install {pkg["name"]}"',
            ''  # Empty line for readability
        ])
    
    return template.replace('{{INSTALL_COMMANDS}}', '\n'.join(install_commands))

def main():
    # Create necessary directories
    os.makedirs('opt/packages', exist_ok=True)
    
    with open('Dockerfile', 'w') as f:
        f.write(generate_dockerfile())
    
    with open('install.sh', 'w') as f:
        f.write(generate_install_script())

if __name__ == '__main__':
    main() 