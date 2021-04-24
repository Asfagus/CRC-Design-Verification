class c_186_2;
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

program p_186_2;
    c_186_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0011x010zz1x1z11z1x1x0zx1x1xxxzzzxzzzzxzzzzxxzzxzzzxxzxxxzxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
