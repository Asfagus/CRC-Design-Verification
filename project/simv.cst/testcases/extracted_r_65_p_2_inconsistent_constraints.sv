class c_65_2;
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

program p_65_2;
    c_65_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x01x100xz11x000111xxx1x0z1x10x0xzxxxzzxxzzzxzzxzxxzxzxxzxzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
