class c_2_2;
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

program p_2_2;
    c_2_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "001x0xzzzzz1x100zzx00x1x000zzzxxxxzxxxxxxxzzxzxxxzzzzzxzzxxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
