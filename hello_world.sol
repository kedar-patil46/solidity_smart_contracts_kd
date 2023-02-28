contract Hello_World
{
    event messagechanged(string oldmsg, string newmsg);

    string public message;

    constructor (string memory firstmsg)
    {
        message = firstmsg;
    }

    function update(string memory scndmsg) public
    {
        string memory oldmsg = message;

        message = scndmsg;

        emit messagechanged(oldmsg, scndmsg);
    }
}
