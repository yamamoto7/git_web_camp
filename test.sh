#!/bin/zsh

for i in `seq 1 7`
do
  git checkout master
  echo "a" >> a.txt
  git add .
  git commit -m a
  git push origin master

  git checkout test
  echo "b" >> b.txt
  git add .
  git commit -m b
  git push origin test
done
