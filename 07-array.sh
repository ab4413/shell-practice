#!/bin/bash
MOVIES=("Inception" "Interstellar" "The Dark Knight" "Memento" "Dunkirk")
echo "my first movie is: ${MOVIES[0]}"
echo "my second movie is: ${MOVIES[3]}"
echo "my third movie is: ${MOVIES[4]}"
echo "all movies:${MOVIES[@]}"