class c_163_2;
    rand bit[7:0] data_6_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_6_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_6_ != 8'hbc);
    }
endclass

program p_163_2;
    c_163_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0xzzxzzxz0x010x00z0000x01zx000zxzzxxzxzxxxxzxxzzzzxxxzxxxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
