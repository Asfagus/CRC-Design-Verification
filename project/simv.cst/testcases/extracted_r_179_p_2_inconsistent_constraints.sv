class c_179_2;
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

program p_179_2;
    c_179_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xz000xx0zzzx0001xx1zzxx0x0111xxxzxxxxxzzxxzxxxxzzxzxzzzzzxzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
