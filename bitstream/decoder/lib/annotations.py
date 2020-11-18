#!/usr/bin/python

class Annotations:
    '''
       Class to hold the annotation formats
       To be used at multiple levels in tool flow for
       comparison purposes
    '''

    #format strings
    _connect_wire_str = 'connect wire {} ({}) to {}'
    _latch_wire_str   = 'latch wire {} ({}) before connecting to {}'
    _load_reg_str     = 'load `{}` reg with wire'
    _init_reg_str     = 'init `{}` reg with const `{}`'
    _op_config_str    = '{} = {}'
    _read_from_str    = 'read from {} `{}`'
    _comment_str      = '# data[{}] : {}\n'
    _check_tile_str   = '@ tile ({}, {}) {}'

    @classmethod
    def connect_wire(cls, wire_num, src_name, snk_name, row=None, col=None):
        s = cls._connect_wire_str.format(wire_num, src_name, snk_name)
        return cls._check_tile(row, col, s)

    @classmethod
    def latch_wire(cls, wire_num, src_name, snk_name, row=None, col=None):
        s = cls._latch_wire_str.format(wire_num, src_name, snk_name)
        return cls._check_tile(row, col, s)

    # use same one for wire and const
    @classmethod
    def load_reg(cls, reg_name, row=None, col=None):
        s = cls._load_reg_str.format(reg_name)
        return cls._check_tile(row, col, s)

    @classmethod
    def init_reg(cls, reg_name, const, row=None, col=None):
        s = cls._init_reg_str.format(reg_name, const)
        return cls._check_tile(row, col, s)

    # use same for actual ops, input and output...
    @classmethod
    def op_config(cls, op_name, value):
        return cls._op_config_str.format(op_name, value)

    @classmethod
    def read_from(cls, _type, name):
        assert _type in {'reg', 'wire'}
        return cls._read_from_str.format(_type, name)

    @classmethod
    def format_comment(cls, comment):
        s = []
        for bit, c in comment.items():
            s.append(cls._comment_str.format(bit, c))

        return ''.join(s)

    @classmethod
    def _check_tile(cls, row, col, s):
        # currently still printing (x, y) i.e. (col, row). So that it matches p_state and r_state
        # we can transition to row/col eventually
        if row is not None and col is not None:
            return cls._check_tile_str.format(col, row, s)
        else:
            return s
