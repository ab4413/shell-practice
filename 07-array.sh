#!/bin/bash
MOVIES=("Inception" "Interstellar" "The Dark Knight" "Memento" "Dunkirk")
echo "my first movie is: ${MOVIES[0]}"
echo "my second movie is: ${MOVIES[1]}"
echo "my third movie is: ${MOVIES[2]}"
# shellcheck disable=SC2145
echo "all movies:${MOVIES[@]}"