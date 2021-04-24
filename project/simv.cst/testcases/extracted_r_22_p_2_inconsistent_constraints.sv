class c_22_2;
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

program p_22_2;
    c_22_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x011z11zzxxz1zxxzzzx1zz01xz0zzzzxxxzzzzzxxzxxxxxzzzzxxzxzzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
