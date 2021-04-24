class c_192_2;
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

program p_192_2;
    c_192_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx11z00x1x11zx11zx1zx000z1xz10x0zzxxxxzzxxxxxzzxxxzxzzzxzzxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
