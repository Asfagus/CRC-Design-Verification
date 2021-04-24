class c_118_2;
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

program p_118_2;
    c_118_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z1z100zzz0z0x1x0xxx00xx110110z1zxxzxxxxxzxxxzxxxzxxxzzxzxxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
