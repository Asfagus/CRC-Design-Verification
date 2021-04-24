class c_108_2;
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

program p_108_2;
    c_108_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z1x11x0000zz00x0z11x1zx1z1zxx1zxzzzxxxxzxzzxzzxzzzxzzzzxzzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
