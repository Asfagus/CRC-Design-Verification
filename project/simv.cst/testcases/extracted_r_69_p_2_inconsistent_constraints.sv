class c_69_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_69_2;
    c_69_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00x0z11x1xz10z1z0000x1zx10xx0x0zxzxzzzxzxzxxxxzzxzzxxxxzzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
