#!/bin/bash

nazwa=${1%.*}

as ${nazwa}.s -o ${nazwa}.o

ld ${nazwa}.o -o ${nazwa}
