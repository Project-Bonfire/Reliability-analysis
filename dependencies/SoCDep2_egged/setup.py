from setuptools import setup, find_packages
import os

os.environ["MPLCONFIGDIR"] = "."

setup(name='socdep2',
      version='0.1',
      description='Socdep',
      url='https://github.com/siavooshpayandehazad/SoCDep2',
      author='Siavoosh Payandeh Azad',
      author_email='siavoosh@ati.ttu.ee',
      license='MIT',
      packages=find_packages(),
      setup_requires=["numpy"],
      install_requires=[
          'cycler (==0.10.0)',
          'decorator (==4.1.2)',
          'docutils (==0.14)',
          'matplotlib',
          'networkx (==1.11)',
          'Pympler (==0.5)',
          'pyparsing (==2.2.0)',
          'pytz (==2017.2)',
          'simpy (==3.0.10)',
          'six (==1.11.0)',
          'statistics'
      ])
