<?php
class mymodel extends CI_Model {

    var $title   = '';
    var $content = '';
    var $date    = '';

    function __construct()
    {
        // Call the Model constructor
        parent::__construct();
    }
    
    function getAllEmails()
    {
	$query = $this->db->get('potential_emails');
	return $query->result();
    }

    function insertPotentialEmail($email)
    {
	$data['email'] = $email;

	$this->db->insert('potential_emails',$data);
    }
}
