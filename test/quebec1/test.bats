#! /usr/bin/env bats

@test "The dig command should be installed" {
  which dig
}

@test "IP-address correct" {
    skip "NotImplementedYet"
}

@test "FQDN correct" {
    skip "NotImplementedYet"
}

@test "nslookup alfa1" {
    # Forward Lookup
    [ "172.16.1.65" = "$(dig @172.16.1.70 "alfa1.green.local" +short)" ]
    # Reverse Lookup
    #result=$(dig @172.16.1.70 -x "172.16.1.65" +short)
    #[ "alfa1.green.local." = "${result}" ]
}

@test "nslookup bravo1" {
    skip "NotImplementedYet"
    # Forward Lookup
    [ "172.16.1.66" = "$(dig @172.16.1.70 "bravo1.green.local" +short)" ]
    # Reverse Lookup
    result=$(dig @172.16.1.70 -x "172.16.1.66" +short)
    [ "bravo1.green.local." = "${result}" ]
}

@test "nslookup charlie1" {
    skip "NotImplementedYet"
    # Forward Lookup
    [ "172.16.1.67" = "$(dig @172.16.1.70 "charlie1.green.local" +short)" ]
    # Reverse Lookup
    result=$(dig @172.16.1.70 -x "172.16.1.67" +short)
    [ "charlie1.green.local." = "${result}" ]
}

@test "nslookup delta1" {
    skip "NotImplementedYet"
    # Forward Lookup
    [ "172.16.1.68" = "$(dig @172.16.1.70 "delta1.green.local" +short)" ]
    # Reverse Lookup
    result=$(dig @172.16.1.70 -x "172.16.1.68" +short)
    [ "delta1.green.local." = "${result}" ]
}

@test "nslookup echo1" {
    skip "NotImplementedYet"
}

@test "nslookup kilo1" {
    skip "NotImplementedYet"
}

@test "nslookup lima1" {
    skip "NotImplementedYet"
}

@test "nslookup mike1" {
    skip "NotImplementedYet"
}

@test "nslookup november1" {
    skip "NotImplementedYet"
}

@test "nslookup papa1" {
    skip "NotImplementedYet"
}

@test "nslookup oscar1" {
    skip "NotImplementedYet"
}

@test "nslookup zulu1" {
    skip "NotImplementedYet"
}

@test "nslookup www.hogent.be" {
    skip "NotImplementedYet"
}

@test "nslookup www.facebook.com" {
    skip "NotImplementedYet"
}