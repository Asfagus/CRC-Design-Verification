class c_86_2;
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

program p_86_2;
    c_86_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0zzx10z110x100xz10z000xz0010z10xxxxxxzzzxzxzxxxzzzxzxzxxzxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
