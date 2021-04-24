class c_170_2;
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

program p_170_2;
    c_170_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z0xzz0z0z1z00111x01x001x1xz0xzxxxzxzxzzzxzzxxxxzxzxxzxzxzzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
