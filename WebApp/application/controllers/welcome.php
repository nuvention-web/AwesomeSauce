<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Welcome extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -  
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in 
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see http://codeigniter.com/user_guide/general/urls.html
	 */
	public function index()
	{
		$this->load->view('welcome_message');
		$this->load->database();
		$query = $this->db->query('SELECT email FROM potential_emails');

	}

	public function signup()
	{
		$this->load->database();
		$this->load->model('mymodel');

		$this->mymodel->insertPotentialEmail($_POST['email'],$_POST['firstname',$_POST['lastname']);
		
		$data['inserted'] = 'true';
		$this->load->view('welcome_message',$data);
	}

	public function checkAllEmails()
	{
		$this->load->database();
		$this->load->model('mymodel');
		$result = $this->mymodel->getAllEmails();
		
		foreach($result as $row)
		{
			echo $row->email;
			echo "<br>";
		}
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
