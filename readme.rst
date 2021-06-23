**Robot Framework**
===================

.. contents::
   :local:

Introduction
------------

`Robot Framework <http://robotframework.org>`_ is a generic open source
automation framework for acceptance testing, acceptance test driven
development (ATDD), and robotic process automation (RPA). It has simple plain
text syntax and it can be extended easily with libraries implemented using
Python or Java.

.. image:: https://img.shields.io/pypi/v/robotframework.svg?label=version
   :target: https://pypi.python.org/pypi/robotframework
   :alt: Latest version

Installation
------------

If you already have Python_ with `pip <http://pip-installer.org>`_ installed,
you can simply run::

    pip install robotframework

Example
-------

Below is a simple example test case for testing login to some system.
You can find more examples with links to related demo projects from
http://robotframework.org.

.. code:: robotframework

    *** Settings ***
    Documentation     A test suite with a single test for valid login.
    ...
    ...               This test has a workflow that is created using keywords in
    ...               the imported resource file.
    Resource          resource.robot

    *** Test Cases ***
    Valid Login
        Open Browser To Login Page
        Input Username    demo
        Input Password    mode
        Submit Credentials
        Welcome Page Should Be Open
        [Teardown]    Close Browser

Usage
-----

Tests (or tasks) are executed from the command line using the ``robot``
command or by executing the ``robot`` module directly like ``python -m robot``
or ``jython -m robot``.

The basic usage is giving a path to a test (or task) file or directory as an
argument with possible command line options before the path::


    robot -d reports BROWSER:chrome Test_Suite ----> To run entire test suite

    robot -d reports BROWSER:chrome Test_Suite/M01_Book_Flight -----> To run entire tests in that particular module

    robot -d reports BROWSER:chrome Test_Suite/M01_Book_Flight/TC001_Book_Flight.robot -----> To run particular test in that particular module

	pabot -d reports --argumentfile1 arg_chrome.txt --argumentfile2 arg_firefox.txt -v Test_Suite

Editors to be used
------------------


    * Pycharm with IntelliBot@SeleniumLibrary Patched plugin
    * Eclipse with Red editor

Both IntelliBot@SeleniumLibrary Patched plugin & Red editor can be downloaded from the marketplace of the editors.

