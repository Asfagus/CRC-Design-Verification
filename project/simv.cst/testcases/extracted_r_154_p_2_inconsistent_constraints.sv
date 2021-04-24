class c_154_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_154_2;
    c_154_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x11zzz111zzzxx011zx01xz0010z011xxxxxxxxxxxzxxxxxxzzzxxxxzzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
