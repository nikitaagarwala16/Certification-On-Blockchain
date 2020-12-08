pragma solidity ^0.5.11;
import "./impCertification.sol";
contract CertificationFactory
{
    mapping(string=>address) public registeredOrg;
    function newCertificates(string memory organisation) public
    {
        address certi=address(new impCertification(msg.sender,organisation));
        registeredOrg[organisation]=certi;

    }

}
