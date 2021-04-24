class c_8_2;
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

program p_8_2;
    c_8_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xx1x0001x0111zzxxz1zz1zz0x010xxzzzxxxxzzzzzxzzxxzxzxzzzxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
