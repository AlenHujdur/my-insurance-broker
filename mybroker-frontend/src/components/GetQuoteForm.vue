<template>
    <div class="multistep-form container">
      <div class="step" :class="{ hide: currentStep !== 1 }">
        <h2>Step 1: Business Type</h2>
        <label for="businessType">Select your business type:</label>
        <select v-model="selectedBusinessType" id="businessType">
          <option value="">Select</option>
          <option value="solo">Solo Practitioner</option>
          <option value="group">Group Practice</option>
          <option value="clinic">Clinic</option>
          <option value="hospital">Hospital</option>
        </select>
        <button @click="nextStep" :disabled="!selectedBusinessType">Next</button>
      </div>

      <div class="step" :class="{ hide: currentStep !== 2 }">
        <h2>Step 2: Industry</h2>
        <label for="industry">Select your industry:</label>
        <select v-model="selectedIndustry" id="industry">
          <option value="">Select</option>
          <option value="familyMedicine">Family Medicine</option>
          <option value="internalMedicine">Internal Medicine</option>
          <option value="pediatrics">Pediatrics</option>
          <option value="surgery">Surgery</option>
          <option value="obstetricsGynecology">Obstetrics & Gynecology</option>
          <!-- Add more options based on your specific requirements -->
        </select>
        <button @click="nextStep" :disabled="!selectedIndustry">Next</button>
      </div>

      <div class="step" :class="{ hide: currentStep !== 3 }">
        <h2>Step 3: Coverage Needs</h2>
        <p>Specify your coverage needs:</p>

        <label for="policyLimit">Policy Limit:</label>
        <input type="text" id="policyLimit" v-model="policyLimit" placeholder="Enter policy limit" />

        <label for="deductible">Deductible:</label>
        <input type="text" id="deductible" v-model="deductible" placeholder="Enter deductible amount" />

        <label for="coveragePeriod">Coverage Period:</label>
        <select v-model="selectedCoveragePeriod" id="coveragePeriod">
          <option value="">Select</option>
          <option value="1">1 Year</option>
          <option value="2">2 Years</option>
          <option value="3">3 Years</option>
          <option value="4">4 Years</option>
          <option value="5+">more than 5 Years</option>
          <!-- Add more options based on your specific requirements -->
        </select>
        <p>Contact details:</p>
        <ul>
          <li>Email: <input type="email" v-model="email" /></li>
          <li>Phone: <input type="tel" v-model="phone" /></li>
          <li>Name: <input type="text" v-model="name" /></li>
        </ul>
        <button @click="nextStep">Next</button>
      </div>

      <div class="step" :class="{ hide: currentStep !== 4 }">
        <h2>Step 4: Summary</h2>
        <p>Business Type:</p>
        <select v-model="selectedBusinessType" id="businessType">
          <option value="">Select</option>
          <option value="solo">Solo Practitioner</option>
          <option value="group">Group Practice</option>
          <option value="clinic">Clinic</option>
          <option value="hospital">Hospital</option>
        </select>
        <p>Industry:</p>
        <select v-model="selectedIndustry" id="industry">
          <option value="">Select</option>
          <option value="familyMedicine">Family Medicine</option>
          <option value="internalMedicine">Internal Medicine</option>
          <option value="pediatrics">Pediatrics</option>
          <option value="surgery">Surgery</option>
          <option value="obstetricsGynecology">Obstetrics & Gynecology</option>
          <!-- Add more options based on your specific requirements -->
        </select>
        <p>
          Coverage needs:
          <ul>
            <li>Policy Limit: <input type="text" id="policyLimit" v-model="policyLimit" /></li>
            <li> Deductible: <input type="text" id="deductible" v-model="deductible" /></li>
            <li>
              <label for="summaryCoveragePeriod">Coverage Period:</label>
              <select id="summaryCoveragePeriod" v-model="selectedCoveragePeriod">
                <option value="">Select</option>
                <option value="1">1 Year</option>
                <option value="2">2 Years</option>
                <option value="3">3 Years</option>
                <!-- Add more options based on your specific requirements -->
              </select>
            </li>
          </ul>
        </p>
        <p>Contact details:</p>
        <ul>
          <li>Email: <input type="email" v-model="email" /></li>
          <li>Phone: <input type="tel" v-model="phone" /></li>
          <li>Name: <input type="text" v-model="name" /></li>
        </ul>
        <div class="button-container">
          <button class="btn btn-primary" @click="submitForm">
            {{ isFormSaved ? 'Update' : 'Submit' }}
          </button>
          <button v-if="isFormSaved" class="btn btn-danger" @click="resetForm">
            Reset
          </button>
        </div>
      </div>

      <!-- Modal -->
      <div class="modal" :class="{ 'modal-open': showModal }">
        <div class="modal-content">
          <h2>Form Submitted Successfully!</h2>
          <p>Thank you {{ this.name }} for submitting the form.</p>
          <button class="btn btn-primary" @click="hideModal">OK</button>
        </div>
      </div>
    </div>
  </template>

  <script>
  import axios from 'axios';
  export default {
    name: 'GetQuoteComponent',
    data() {
      return {
        currentStep: 1,
        selectedBusinessType: '',
        selectedIndustry: '',
        industry: '',
        policyLimit: '',
        deductible: '',
        selectedCoveragePeriod: '',
        email: '',
        phone: '',
        name: '',
        showModal: false, // Added showModal data property
      };
    },
    mounted() {
      // Retrieve saved data from localStorage if available
      const savedData = localStorage.getItem('quoteFormData');
      if (savedData) {
        const parsedData = JSON.parse(savedData);
        this.selectedBusinessType = parsedData.selectedBusinessType;
        this.selectedIndustry = parsedData.selectedIndustry;
        this.industry = parsedData.industry;
        this.policyLimit = parsedData.policyLimit;
        this.deductible = parsedData.deductible;
        this.selectedCoveragePeriod = parsedData.selectedCoveragePeriod;
        this.email = parsedData.email;
        this.phone = parsedData.phone;
        this.name = parsedData.name;

        // Set the current step based on the retrieved data
        if (
          this.selectedBusinessType &&
          this.selectedIndustry &&
          this.policyLimit &&
          this.deductible &&
          this.selectedCoveragePeriod &&
          this.email &&
          this.phone &&
          this.name
        ) {
          this.currentStep = 4; // Show the summary step if all data is available
        } else if (this.selectedBusinessType && this.selectedIndustry) {
          this.currentStep = 3; // Show the coverage needs step if business type and industry are selected
        } else if (this.selectedBusinessType) {
          this.currentStep = 2; // Show the industry step if business type is selected
        } else {
          this.currentStep = 1; // Show the first step if no data is available
        }
      }
    },
    computed: {
      isFormSaved() {
        return (
          this.selectedBusinessType &&
          this.selectedIndustry &&
          this.policyLimit &&
          this.deductible &&
          this.selectedCoveragePeriod &&
          this.email &&
          this.phone &&
          this.name
        );
      },
    },
    methods: {
      nextStep() {
        this.currentStep++;
      },
      submitForm() {
        // Save form data to localStorage
        localStorage.setItem(
          'quoteFormData',
          JSON.stringify({
            selectedBusinessType: this.selectedBusinessType,
            selectedIndustry: this.selectedIndustry,
            industry: this.industry,
            policyLimit: this.policyLimit,
            deductible: this.deductible,
            selectedCoveragePeriod: this.selectedCoveragePeriod,
            email: this.email,
            phone: this.phone,
            name: this.name,
          })
        );
        // Show the modal
        this.showModal = true;
        this.subscribe();
      },
      hideModal() {
        // Hide the modal
        this.showModal = false;

        // Reset the current step
        if(!this.isFormSaved) {
            this.currentStep = 1;
        }
      },
      resetForm() {
        // Clear form data from localStorage
        localStorage.removeItem('quoteFormData');

        // Reset form fields and step
        this.selectedBusinessType = '';
        this.selectedIndustry = '';
        this.industry = '';
        this.policyLimit = '';
        this.deductible = '';
        this.selectedCoveragePeriod = '';
        this.email = '';
        this.phone = '';
        this.name = '';
        this.currentStep = 1;
      },
      async subscribe() {

    const headers = {
        'Content-Type': 'application/json'
    };
    axios.post('https://mybrokerservice-ijciww6s2q-ew.a.run.app/api/v1/new-requested-quote', {
        subscriber: {
                email: this.email,
                phone: this.phone,
                name: this.name,
            },
            business_type: this.selectedBusinessType,
            industry: this.selectedIndustry,
            policy_limit: this.policyLimit,
            deductible: this.deductible,
            coverage_period: this.selectedCoveragePeriod,

     }, { headers })
        .then(response => {
        console.log(response, 'Subscribed successfully!');
        this.showModal = true;
        })
        .catch(error => {
        console.error('Error subscribing:', error);
        });
    },
    },
  };
  </script>

  <style scoped>
  .multistep-form {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 70vh;
  }

  .hide {
    display: none;
  }

  .step {
    margin-bottom: 20px;
  }

  .modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 9999;
  }

  .modal-open {
    display: block;
  }

  .modal-content {
    position: relative;
    max-width: 400px;
    margin: 100px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 4px;
  }

  .button-container {
    display: flex;
    justify-content: space-between;
  }
  </style>
