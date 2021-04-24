class c_125_2;
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

program p_125_2;
    c_125_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111zxxzzzzz0zz1z10xxxzx1x1zxzxzzxzzxxxzxzzzxxzxzxxxzxzxzxxzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
