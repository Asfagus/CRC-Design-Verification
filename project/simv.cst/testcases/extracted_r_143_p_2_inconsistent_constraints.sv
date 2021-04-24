class c_143_2;
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

program p_143_2;
    c_143_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z100z01100zzx1xx1x01zz1001z01x0xzzzxzzzzxzxxxzxxzzzzzxzxxzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
