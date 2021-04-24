class c_147_2;
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

program p_147_2;
    c_147_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00xzxxx00zxzzzx00zzzxzx11x11x1zxxzzzxzxzxzxzxzzxxxxzzxzzzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
