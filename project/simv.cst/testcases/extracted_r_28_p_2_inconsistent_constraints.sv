class c_28_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_28_2;
    c_28_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx00z1x0x1z11110xxz1zz01zx1x10x1zzxzzzzzzzzxzzzzzxzxxxxxxzzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
