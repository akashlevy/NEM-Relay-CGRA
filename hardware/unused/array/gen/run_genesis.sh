#!/bin/bash

DESIGN=test_top

DIR=`pwd`
RTL_DIR=${DIR}/../rtl

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

