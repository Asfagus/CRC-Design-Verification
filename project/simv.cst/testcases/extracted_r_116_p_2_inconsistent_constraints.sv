class c_116_2;
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

program p_116_2;
    c_116_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x11x1xzzx1zxzx10x1zz100xz0111z0zxxxxxxxzzxzxzzzxxxzzxzxzxxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
