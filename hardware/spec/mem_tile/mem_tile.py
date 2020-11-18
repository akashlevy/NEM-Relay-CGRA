#!/usr/bin/python

class mem_config(object):
  def __init__(self):
    self.mode = "lb"
    self.depth = 512
    self.chain_en = 0
    self.tile_en = 0
    self.almost_full_count = 0
    super(mem_config, self).__init__()

class mem_instance(object):
  def __init__(self):
    self.core = []
    for i in range(self.depth):
      self.core.append('X')
    super(mem_instance, self).__init__()

  def read(self, addr):
    return self.core[addr]

  def write(self, addr, data):
    self.core[addr]=data

class mem_tile_core(mem_config, mem_instance):
  def __init__(self):
    super(mem_tile_core, self).__init__()
    self.int_rd_data_nnn = 'X'    
    self.int_rd_data_nn  = 'X'    
    self.int_valid_nnn = 0    
    self.int_valid_nn  = 0   

    self.int_rd_addr_n = 0
    self.int_wr_addr_n = 0
    self.int_read_count_n = 0
    self.int_word_count_n = 0
    self.int_lb_ren_n = 0
    self.int_rd_data_n = 'X'
    self.int_valid_n  = 0  

    self.int_rd_addr = 0
    self.int_wr_addr = 0
    self.int_read_count = 0
    self.int_word_count = 0
    self.int_lb_ren = 0

  def clock(self, wdata, chain_wdata, wen, chain_wen, ren, raddr, waddr):
    wr_data = chain_wdata if (self.chain_en==1) else wdata
    wr_wen = chain_wen if (self.chain_en==1) else wen
    if (self.tile_en == 1):
      if (self.mode=="lb"):
        if (wr_wen==1):
          if (self.int_wr_addr<self.depth-1):
            self.int_wr_addr_n = self.int_wr_addr + 1
          else:
            self.int_wr_addr_n = 0

        if (self.int_lb_ren==0 and (self.int_word_count==self.depth-1)):
          self.int_lb_ren_n = 1
        elif (self.int_lb_ren==1 and (self.int_read_count==self.depth-1)):
          if (self.int_word_count==self.depth):
            self.int_lb_ren_n = 1
          else:
            self.int_lb_ren_n = 0

        if (self.int_lb_ren==1):
          if (self.int_read_count<(self.depth-1)):
             self.int_read_count_n = self.int_read_count + 1
          else:
             self.int_read_count_n = 0

        if (wr_wen==1 and self.int_lb_ren==0  and (self.int_word_count < self.depth)):
          self.int_word_count_n = self.int_word_count + 1
        elif (wr_wen==0 and self.int_lb_ren==1  and (self.int_word_count > 0)):
          self.int_word_count_n = self.int_word_count - 1
        elif (wr_wen==1 and ren==1 and (self.int_word_count==0)):
          self.int_word_count_n = self.int_word_count + 1

        if (self.int_lb_ren==1):
          if (self.int_rd_addr<(self.depth-1) and (self.int_word_count > 0)):
            self.int_rd_addr_n = self.int_rd_addr + 1
          elif (self.int_rd_addr==(self.depth-1) and (self.int_word_count > 0)):
            self.int_rd_addr_n = 0
 
        if (self.int_lb_ren==1):
          rd_data = self.core[self.int_rd_addr]
        else:
          rd_data = 'X'

        if (wr_wen==1): 
          self.core[self.int_wr_addr] = wr_data

        valid = 1 if (self.int_lb_ren==1 and self.int_word_count>0) else 0
        almost_full = 1 if ((self.depth - self.int_word_count - 1) < self.almost_full_count) else 0

        #print ("C: RADDR={:d} WADDR={:d} RDCNT={:d} WDCNT={:d} LBREN={:d}".format(self.int_rd_addr, self.int_wr_addr, self.int_read_count, self.int_word_count, self.int_lb_ren))
        #print (" N: RADDR={:d} WADDR={:d} RDCNT={:d} WDCNT={:d} LBREN={:d}".format(self.int_rd_addr_n, self.int_wr_addr_n, self.int_read_count_n, self.int_word_count_n, self.int_lb_ren_n))

        self.int_rd_addr      =  self.int_rd_addr_n
        self.int_wr_addr      =  self.int_wr_addr_n
        self.int_read_count   =  self.int_read_count_n
        self.int_word_count   =  self.int_word_count_n
        self.int_lb_ren       =  self.int_lb_ren_n

        return [rd_data, valid, almost_full] 
###################################################################################
##
## FIFO MODE 
##
###################################################################################
      elif (self.mode=="fifo"):
        if (wr_wen==1):
          if (self.int_wr_addr<self.depth-1):
            self.int_wr_addr_n = self.int_wr_addr + 1
          else:
            self.int_wr_addr_n = 0

        if (wr_wen==1 and ren==0 and (self.int_word_count < self.depth)):
          self.int_word_count_n = self.int_word_count + 1
        elif (wr_wen==0 and ren==1 and (self.int_word_count > 0)):
          self.int_word_count_n = self.int_word_count - 1
        elif (wr_wen==1 and ren==1 and (self.int_word_count==0)):
          self.int_word_count_n = self.int_word_count + 1
       

        if (ren==1):
          if (self.int_rd_addr<(self.depth-1) and (self.int_word_count > 0)):
            self.int_rd_addr_n = self.int_rd_addr + 1
          elif (self.int_rd_addr==(self.depth-1) and (self.int_word_count > 0)):
            self.int_rd_addr_n = 0
 
        if (ren==1):
          rd_data = self.core[self.int_rd_addr]
        else:
          rd_data = 'X'

        if (wr_wen==1): 
          self.core[self.int_wr_addr] = wr_data

        valid = 1 if (ren==1 and self.int_word_count>0) else 0
        almost_full = 1 if ((self.depth - self.int_word_count - 1) < self.almost_full_count) else 0

        #print ("C: RADDR={:d} WADDR={:d} RDCNT={:d} WDCNT={:d} WEN={:d} REN={:d}".format(self.int_rd_addr, self.int_wr_addr, self.int_read_count, self.int_word_count, wen, ren))
        #print (" N: RADDR={:d} WADDR={:d} RDCNT={:d} WDCNT={:d}".format(self.int_rd_addr_n, self.int_wr_addr_n, self.int_read_count_n, self.int_word_count_n))

        self.int_rd_addr      =  self.int_rd_addr_n
        self.int_wr_addr      =  self.int_wr_addr_n
        self.int_word_count   =  self.int_word_count_n
        self.int_rd_data_nnn  =  self.int_rd_data_nn
        self.int_rd_data_nn   =  self.int_rd_data_n
        self.int_rd_data_n    =  rd_data
        self.int_valid_nnn  =  self.int_valid_nn
        self.int_valid_nn   =  self.int_valid_n
        self.int_valid_n    =  valid


        return [self.int_rd_data_nnn, self.int_valid_nnn, almost_full] 
###################################################################################
##
## SRAM MODE 
##
###################################################################################
      elif (self.mode=="sram"):
        if (ren==1):
          rd_data = self.core[raddr]
        else:
          rd_data = 'X'

        if (wr_wen==1): 
          self.core[waddr] = wdata

        valid = 'X'
        almost_full = 'X'

        self.int_rd_data_nnn  =  self.int_rd_data_nn
        self.int_rd_data_nn   =  self.int_rd_data_n
        self.int_rd_data_n    =  rd_data

        return [self.int_rd_data_nnn, 'X', 'X'] 
###################################################################################
##
## Tile Disabled
##
###################################################################################
    else:
      return ['X',0,'X']



###################################################################################
##
## Instantiate memory tile
##
###################################################################################

mem_tile = mem_tile_core()
mem_tile.depth=16
mem_tile.tile_en = 1
mem_tile.almost_full_count = 4

#LB_TEST:
mem_tile.mode = "lb"
for i in range(80):
#clock(wdata, chain_wdata, wen, chain_wen, ren, raddr, waddr):
  wen=0
  if ((0 <= i <= 40) or (51<=i<=60)):
    wen=1
  print "--------------------------\ncycle ", i, "wen ", wen
  ret = mem_tile.clock(i,0,wen,0,0,0,0)
  print "MEM_OUT_DATA:", ret[0], " VALID:", ret[1], " ALMOST_FULL:", ret[2]

##FIFO_TEST:
#mem_tile.mode = "fifo"
#for i in range(80):
##clock(wdata, chain_wdata, wen, chain_wen, ren, raddr, waddr):
#  wen=0
#  ren=0
#  if ((0 <= i <= 10) or (20<=i<=50) or (63<=i<=63)):
#    wen=1
#  if ((12 <= i <= 22) or (30<=i<=70)):
#    ren=1
#
#  print "--------------------------\ncycle ", i, "wen ", wen, "ren ", ren
#  ret = mem_tile.clock(i,0,wen,0,ren,0,0)
#  print "MEM_OUT_DATA:", ret[0], " VALID:", ret[1], " ALMOST_FULL:", ret[2]

##SRAM_TEST
#mem_tile.mode = "sram"
### Write to SRAM
#for i in range(40):
##clock(wdata, chain_wdata, wen, chain_wen, ren, raddr, waddr):
#  if (i%2==0):
#    wdata=i+100
#  else:
#    wdata=i*2
#  ret = mem_tile.clock(wdata,0,1,0,0,0,i)
### Readback
#for i in range(15):
#  print "--------------------------\ncycle ", i, "wen ", 0, "ren ", 1
#  ret = mem_tile.clock(0,0,0,0,1,i,0)
#  print "MEM_OUT_DATA:", ret[0], " VALID:", ret[1], " ALMOST_FULL:", ret[2]

