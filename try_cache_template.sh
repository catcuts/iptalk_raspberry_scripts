#!/usr/bin/bash

{ # your 'try' block
    echo 'start !'
    meow && \
    echo 'wong !' && \
    echo 'tried'
} || { # your 'catch' block
    echo 'catched'
}

echo 'meow !' # finally: this will always happen