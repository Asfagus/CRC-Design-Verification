class c_153_2;
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

program p_153_2;
    c_153_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111z00111x1x1011zxzz1zzxxxx10000xxzzxzzzxzxzxxxzxxzzxxzxxxxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
