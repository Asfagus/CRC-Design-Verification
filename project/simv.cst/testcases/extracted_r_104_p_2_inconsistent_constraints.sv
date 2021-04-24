class c_104_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_104_2;
    c_104_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "110zzxz0z0zz1zz110xz1101zxz1z1x0xzxxxxzzzxxzzzxzzzxxzxzzxzxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
