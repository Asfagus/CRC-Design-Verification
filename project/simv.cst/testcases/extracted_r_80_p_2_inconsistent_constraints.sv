class c_80_2;
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

program p_80_2;
    c_80_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x101x11z10z1xxx1x1100011x010xzzzzxxxxzxzxzxxzxxzzzxzzxzxzzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
