# Author:       Cedric Denoo ( https://github.com/cdenoo )
# Description:  This script downloads roles specified in a YML file into an ansible directory


import yaml
import git
import sys
import argparse

DEFAULT_YML_PATH='./ansible/site.yml'
DEFAULT_ROLES_PATH='./ansible/roles'

parser = argparse.ArgumentParser()
parser.add_argument('--yml', default=DEFAULT_YML_PATH, help='YML file to download roles from')
parser.add_argument('--roledir', default=DEFAULT_ROLES_PATH, help='Ansible roles directory to download roles to')
parser.add_argument('--debug', action='store_true', help='Run the script in debug mode')
args = parser.parse_args()

def main():
    install_roles(read_yml(args.yml))

def read_yml(file_path):
    with open(file_path) as f:
        data = yaml.load(f, Loader=yaml.FullLoader)
        roles = []
        for item in data:
            if item.get('roles') is not None:
                for role in item.get('roles'):
                    roles.append(role)
        return roles

# Clone roles from github to the ./ansible/roles/ directory
def install_roles(roles):
    for role in roles:
        split_role = role.split(".")
        # To be downloaded, a role has to follow the `username.rolename` pattern
        if len(split_role) >= 2:
            owner = split_role[0]
            role = split_role[1]
            repo_url = f'https://github.com/{owner}/ansible-role-{role}'
            alt_repo_url = f'https://github.com/{owner}/ansible-{role}'
            install_path = f'{args.roledir}/{owner}.{role}'
            try:
                git.Repo.clone_from(url=repo_url, to_path=install_path)
            except:
                try:
                    git.Repo.clone_from(url=alt_repo_url, to_path=install_path)
                except git.exc.GitCommandError as error:
                    if args.debug:
                        print(error)

if __name__ == "__main__":
    main()