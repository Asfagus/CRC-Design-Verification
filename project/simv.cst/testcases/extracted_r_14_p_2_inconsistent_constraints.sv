class c_14_2;
    rand bit[7:0] data_8_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_8_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_8_ != 8'hbc);
    }
endclass

program p_14_2;
    c_14_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz10z1xx0z0zz0xzzx00zx0x111xz100xzxxzzzzzzxzxzxxzxxzzzzxxxzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
