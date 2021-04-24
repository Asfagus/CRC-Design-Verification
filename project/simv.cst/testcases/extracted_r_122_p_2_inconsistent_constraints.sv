class c_122_2;
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

program p_122_2;
    c_122_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0110x0x00x101xzxz0x0010z11x1100xzzxzzzzxxxxxzxxxxxzxxxzxxxxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
