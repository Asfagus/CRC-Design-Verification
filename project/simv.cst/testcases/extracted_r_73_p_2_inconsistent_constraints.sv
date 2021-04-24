class c_73_2;
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

program p_73_2;
    c_73_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzxx1zzzxz1x0xzx0100zx0zxz100xx1zzzxxxzzxxxxzxxzxzxzxxxxxzzxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
