//C wrapper function that invokes assembly code to read 
//byte from specified port
unsigned char port_byte_read(unsigned short port) {
    unsigned char result;
    __asm__("in %%dx, %%al"//assembly code that stores value from port written in dx to register al
    : "=a" (result)        //al should be assigned to result
    : "d" (port)           //dx should be assigned to port
    );
    return result;
}

//C wrapper to store byte to specified port
void port_byte_write(unsigned short port, unsigned char data){
    __asm__(
    "out %%al, %%dx"//assebmly code that stores value from al to port, specified by dx register 
    :                       //there is no output to c code
    : "a"(data), "d" (port) //al assigned to data, dx to port
    );
}

//C wrapper to fetch word from specified port
unsigned short port_word_read(unsigned char port) {
    unsigned short result; 
    __asm__(
        "in %%dx, %%ax"
        :"=a"(result)
        :"d" (port)
    );
    return result;
}


void port_word_write(unsigned char port, unsigned short data){
    __asm__(
        "out %%ax, %%dx"
        :
        : "a"(data), "d"(port)
    );
}