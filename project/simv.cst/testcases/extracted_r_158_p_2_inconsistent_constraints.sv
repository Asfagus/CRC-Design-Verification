class c_158_2;
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

program p_158_2;
    c_158_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1010010111x0xx10x11z10z1xz10x1x1xzxxzxzxzxzzzzxxxzxxxxzzxzzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
