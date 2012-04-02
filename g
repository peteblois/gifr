#!/usr/bin/python

import os
import subprocess
import sys

nacl_root = '/Users/pete/Code/nacl/'
nacl_ports_root = os.path.join(nacl_root, 'naclports')

def main():
  os.putenv('NACL_SDK_ROOT', '/Users/pete/Code/nacl/nacl_sdk/pepper_18/')

  if (len(sys.argv) > 1):
    if (sys.argv[1] == 'chrome'):
      start_chrome()
    if (sys.argv[1] == 'nacl_ports'):
      nacl_ports();


def start_chrome():
  os.putenv('NACL_DEBUG_ENABLE', '1')
  os.putenv('NACL_PLUGIN_DEBUG', '1')
  os.putenv('NACLVERBOSITY', '3')

  subprocess.call([
    "/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
  ])

def nacl_ports():
  install_nacl_port('boost_1_47_0')
  install_nacl_port('zlib-1.2.3')
  install_nacl_port('libpng-1.2.40')

def install_nacl_port(name):
  install_dir = os.path.join(nacl_ports_root, 'src', 'libraries', name)
  os.chdir(install_dir)

  sh = os.path.join(install_dir, 'nacl-%s.sh' % name)
  os.putenv('NACL_PACKAGES_BITSIZE', '32');
  subprocess.call([sh])

  os.putenv('NACL_PACKAGES_BITSIZE', '64');
  subprocess.call([sh])

if __name__ == "__main__":
  main()
