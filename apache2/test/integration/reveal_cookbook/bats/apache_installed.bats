#!/usr/bin/env bats

@test "Apache 2 is installed" {
    run which apache2
    [ "$status" -eq 0 ]
}
