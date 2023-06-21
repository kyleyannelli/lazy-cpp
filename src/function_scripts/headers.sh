#!/bin/bash
### DO NOT ADD CODE THAT EXECUTES COMMANDS HERE. THIS FILE IS ONLY FOR DEFINING FUNCTIONS ###
### DO NOT ADD CODE THAT EXECUTES COMMANDS HERE. THIS FILE IS ONLY FOR DEFINING FUNCTIONS ###
### DO NOT ADD CODE THAT EXECUTES COMMANDS HERE. THIS FILE IS ONLY FOR DEFINING FUNCTIONS ###
### DO NOT ADD CODE THAT EXECUTES COMMANDS HERE. THIS FILE IS ONLY FOR DEFINING FUNCTIONS ###
function welcome_banner() {
  # if at least 68 columns wide
  if [ $(tput cols) -ge 68 ]; then
    printf "\e[94m
      ██╗      █████╗ ███████╗██╗   ██╗      ██████╗██████╗ ██████╗
      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝     ██╔════╝██╔══██╗██╔══██╗
      ██║     ███████║  ███╔╝  ╚████╔╝█████╗██║     ██████╔╝██████╔╝
      ██║     ██╔══██║ ███╔╝    ╚██╔╝ ╚════╝██║     ██╔═══╝ ██╔═══╝
      ███████╗██║  ██║███████╗   ██║        ╚██████╗██║     ██║
      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝         ╚═════╝╚═╝     ╚═╝\e[0m\n"
    printf "\e[94m      Version %s | Written by Kyle Yannelli (KMFG)\e[0m\n" $CPP_LAZY_VERSION
    echo ""
  else
    printf "\e[94mLAZY-CPP\e[0m\n"
    printf "\e[94mVersion %s | Written by Kyle Yannelli (KMFG)\e[0m\n" $CPP_LAZY_VERSION
  fi
}

function error_start_banner() {
  # if at least 68 columns wide
  if [ $(tput cols) -ge 68 ]; then
    printf "\e[91m
      ███████╗██████╗ ██████╗  ██████╗ ██████╗
      ██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
      █████╗  ██████╔╝██████╔╝██║   ██║██████╔╝
      ██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██╗
      ███████╗██║  ██║██║  ██║╚██████╔╝██║  ██║
      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
    \e[0m\n"
  else
    printf "\e[91m*****ERROR*****\e[0m\n"
  fi
}

function error_end_banner() {
  printf ""
}

function warning_start_banner() {
  if [ $(tput cols) -ge 68 ]; then
    printf "\e[93m
      ██╗    ██╗ █████╗ ██████╗ ███╗   ██╗
      ██║    ██║██╔══██╗██╔══██╗████╗  ██║
      ██║ █╗ ██║███████║██████╔╝██╔██╗ ██║
      ██║███╗██║██╔══██║██╔══██╗██║╚██╗██║
      ╚███╔███╔╝██║  ██║██║  ██║██║ ╚████║
       ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
    \e[0m\n"
  else
    printf "\e[93m*****WARNING*****\e[0m\n"
  fi
}

function warning_end_banner() {
  printf ""
}

function info_start_banner() {
  if [ $(tput cols) -ge 68 ]; then
    printf "\e[92m
      ██╗███╗   ██╗███████╗ ██████╗
      ██║████╗  ██║██╔════╝██╔═══██╗
      ██║██╔██╗ ██║█████╗  ██║   ██║
      ██║██║╚██╗██║██╔══╝  ██║   ██║
      ██║██║ ╚████║██║     ╚██████╔╝
      ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝
    \e[0m\n"
  else
    printf "\e[92m*****INFO*****\e[0m\n"
  fi
}

function info_end_banner() {
  printf ""
}