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

    function trackNewRoute($data)
	{
		$data['id'] = md5(microtime());
		$this->db->insert('location_tracker',$data);
		
		return $data['id'];
	}

	function updateRouteByID($data)
	{
		$id = $data['id'];
		unset($data['id'];
		$this->db->update('location_tracker',$data, array('id' => $id));
	}

	function getRouteByID($id)
	{
		$query = $this->db->get_where('location_tracker',array('id' => $id));
		return $query->row_array();
	}
}
