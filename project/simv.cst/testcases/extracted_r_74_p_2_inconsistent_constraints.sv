class c_74_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_74_2;
    c_74_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xx10z0x01011z00101001xxzx1z1zxzzzxxzxxzzxxxxzxxzzzxxxxzxzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
