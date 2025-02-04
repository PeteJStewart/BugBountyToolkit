#!/usr/bin/env python3

import os
import glob

def get_package_type(content):
    for line in content.splitlines():
        if line.startswith('PACKAGE_TYPE='):
            return line.split('=')[1].strip('"\'')
    return 'unknown'

def get_package_url(content):
    for line in content.splitlines():
        if line.startswith('PACKAGE_URL='):
            return line.split('=')[1].strip('"\'')
    return 'No repository URL specified'

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
    
    # Process each package individually
    for pkg in packages:
        script_name = f"{pkg['name']}.sh"
        package_url = get_package_url(pkg['content'])
        # Add comment with package name and URL
        install_commands.append(f'# Package: {pkg["name"]}')
        install_commands.append(f'# URL: {package_url}')
        # Add copy command for the package script
        install_commands.append(f'COPY scripts/packages/{script_name} /opt/packages/')
        # Add the installation command for this specific package
        install_commands.append('RUN /bin/bash -c \'' + \
            f'source /opt/packages/{pkg["name"]}.sh && ' + \
            'install && ' + \
            f'test || echo "Failed to install {pkg["name"]}"\'')
        # Add empty line for readability
        install_commands.append('')
    
    return template.replace('{{INSTALL_COMMANDS}}', '\n'.join(install_commands))

def generate_install_script():
    with open('templates/install.template') as f:
        template = f.read()
    
    packages = read_package_scripts()
    install_commands = []
    
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