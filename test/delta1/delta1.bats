#!/usr/bin/env bats

nic="eth1"

# IP and routing
@test "Correct IP address" {
    ipaddr="172.16.1.68"
    # Courtesy of https://stackoverflow.com/questions/13322485/
    result=$(ip a | grep ${nic} | sed -En 's/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
    [ "${result}" = "${ipaddr}" ]
}
@test "Correct nameserver 1" {
    result=$(cat /etc/resolv.conf | grep '172.16.1.66')
    [ ! -z "${result}" ]
}
@test "Correct nameserver 2" {
    result=$(cat /etc/resolv.conf | grep '172.16.1.67')
    [ ! -z "${result}" ]
}

# Firewall
@test "Firewall is running" {
    result=$(sudo systemctl status firewalld | grep 'Active' | sed 's/^[[:space:]]*//' | cut -d' ' -f1-3)
    [ "${result}" = "Active: active (running)" ]
}
@test "Service 'https' allowed through firewall" {
    result=$(sudo firewall-cmd --list-all | grep 'services.*https')
    [ ! -z "${result}" ]
}
@test "Service 'imaps' allowed through firewall" {
    result=$(sudo firewall-cmd --list-all | grep 'services.*imaps')
    [ ! -z "${result}" ]
}
@test "Service 'smtps' allowed through firewall" {
    result=$(sudo firewall-cmd --list-all | grep 'services.*smtps')
    [ ! -z "${result}" ]
}
@test "Service 'smtp-submission' allowed through firewall" {
    result=$(sudo firewall-cmd --list-all | grep 'services.*smtp-submission')
    [ ! -z "${result}" ]
}
@test "Service 'ldap' allowed through firewall" {
    result=$(sudo firewall-cmd --list-all | grep 'services.*ldap')
    [ ! -z "${result}" ]
}