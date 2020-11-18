#!/bin/bash

DESIGN=test_pe

DIR=`pwd`
RTL_DIR=${DIR}/../rtl
VER_DIR=${DIR}/../verif/test_pe

echo ${RTL_DIR}
Genesis2.pl                                        \
    -parse                                                                                          \
    -srcpath                                                                                        \
        ${RTL_DIR}  \
    -incpath                                                                                        \
        ${RTL_DIR} \
    -inputlist                                                                                      \
        ${RTL_DIR}/${DESIGN}.vpf \
    -generate                                                                                       \
    -top ${DESIGN}                                                                                    \
    -depend genesis_sources.list                                                                    \
    -product genesis_vlog.vf                                                                        \
    -synthtop ${DESIGN}                                                                               \
    -hierarchy ${DESIGN}.xml

echo ${VER_DIR}
Genesis2.pl                                        \
    -parse                                                                                          \
    -srcpath                                                                                        \
        ${VER_DIR}  \
    -incpath                                                                                        \
        ${VER_DIR}  \
    -inputlist                                                                                      \
        ${VER_DIR}/${DESIGN}_tb.vpf \
    -generate  \
    -top ${DESIGN}_tb                                                                                    \
    -depend genesis_sources.list                                                                    \
    -product genesis_vlog.verif.vf                                                                        \
