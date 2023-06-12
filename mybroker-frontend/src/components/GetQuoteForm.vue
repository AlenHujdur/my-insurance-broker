<template>
    <div class="multistep-form container">
      <div class="step" :class="{ hide: currentStep !== 1 }">
        <h2>Legal type</h2>
        <label for="naturalPerson">Are you a legal person?</label>
        <select v-model="naturalPerson" id="naturalPerson">
          <option value="">Select</option>
          <option value="yes">Yes</option>
          <option value="no">No</option>
        </select>
        <button @click="nextStep" :disabled="naturalPerson !== 'yes'">Next</button>
        <div v-if="naturalPerson === 'no'" style="color:#00b779">
          You should register your business first.<br>
          Please follow this <a href="link">link</a> to learn more...
        </div>
      </div>

      <div class="step" :class="{ hide: currentStep !== 2 }">
        <h2>Step 2: The revenue</h2>
        <label for="annualRevenue">The revenue of the business</label>
        <input type="number" id="annualRevenue" v-model="annualRevenue"/>
        <p style="color:#00b779">Enter your annual revenue.<br>The revenue of your business in € of the previous year.</p>
        <button @click="nextStep" :disabled="!annualRevenue">Next</button>
      </div>

      <div class="step" :class="{ hide: currentStep !== 3 }">
        <h2>Step 3: Select business industry for which you want a cover</h2>
        <label for="nacebelCodes">NACEBEL Codes:</label>
        <div v-for="cover in covers" :key="cover.code">
          <input type="checkbox" :id="cover.code" v-model="nacebelCodes" :value="cover.code">
          <label :for="cover.code">{{ cover.label_fr }}</label>
        </div>
        <button @click="nextStep" :disabled="!nacebelCodes.length">Next</button>
      </div>
      <div class="step" :class="{ hide: currentStep !== 4 }">
        <h2>Step 4: Fill in business and contact info</h2>
        <ul>
          <li>Enterprise Number:<input type="text" v-model="enterpriseNumber" placeholder="0123456789" /></li>
          <p v-if="!isEnterpriseNumberValid" style="color:#00b779">The Enterprise Number is invalid.<br>Tip: it always starts with 0 and has exactly 10 digits</p>
          <li>Legal name: <input type="text" v-model="legalName" /></li>
          <li>Email: <input type="email" v-model="email" /></li>
          <li>Phone: <input type="tel" v-model="phone" /></li>
          <li>Name: <input type="text" v-model="name" /></li>
        </ul>
        <button @click="nextStep" :disabled="!enterpriseNumber || !legalName || !email || !phone || !name || !isEnterpriseNumberValid">Next</button>
      </div>
      <div class="step" :class="{ hide: currentStep !== 5 }" id="summary">
        <h2>Step 5: Summary</h2>
        <div v-for="cover in covers" :key="cover.code">
          <input type="checkbox" :id="cover.code" v-model="nacebelCodes" :value="cover.code">
          <label :for="cover.code">{{ cover.label_fr }}</label>
        </div>
        <p>
          <ul>
            <li>Annual Revenue: <input type="text" id="annualRevenue" v-model="annualRevenue" /></li>
            <li>Enterprise Number: <input type="text" v-model="enterpriseNumber"/></li>
          </ul>
        </p>
        <p>Contact details:</p>
        <ul>
          <li>Email: <input type="email" v-model="email" /></li>
          <li>Phone: <input type="tel" v-model="phone" /></li>
          <li>Name: <input type="text" v-model="name" /></li>
        </ul>
        <div v-if="showResults">
          <div v-if="result">
            Available: {{ result.data.available }}<br>
            Coverage Ceiling: {{ result.data.coverageCeiling }}<br>
            Deductible: {{ result.data.deductible }}<br>
            Quote ID: {{ result.data.quoteId }}<br>
            <div v-if="result.data.grossPremiums">
              After Delivery: {{ result.data.grossPremiums.afterDelivery }}<br>
              Public Liability: {{ result.data.grossPremiums.publicLiability }}<br>
              Professional Indemnity: {{ result.data.grossPremiums.professionalIndemnity }}<br>
              Entrusted Objects: {{ result.data.grossPremiums.entrustedObjects }}<br>
              Legal Expenses: {{ result.data.grossPremiums.legalExpenses }}<br>
            </div>
          </div>
        </div>
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
  import nacebels from '../../data/nacebels.json';
  export default {
    name: 'GetQuoteComponent',
    data() {
      return {
        currentStep: 1,
        naturalPerson: '',//selectedBusinessType: '',
        nacebelCodes: [],
        annualRevenue:'',//policyLimit: '',
        enterpriseNumber: '',
        legalName: '',
        deductible: '',
        email: '',
        phone: '',
        name: '',
        showModal: false, // Added showModal data property
        url: '',
        covers: [],
        success: false,
        message: '',
        data: null,
        showResults: false,
        result: null,
      };
    },
    mounted() {
      //get covers
      this.getCovers();
      // Retrieve saved data from localStorage if available
      const savedData = localStorage.getItem('quoteFormData');
      if (savedData) {
        const parsedData = JSON.parse(savedData);
        this.naturalPerson = parsedData.naturalPerson;
        this.nacebelCodes = parsedData.nacebelCodes;
        this.enterpriseNumber = parsedData.enterpriseNumber;
        this.annualRevenue = parsedData.annualRevenue;
        this.legalName = parsedData.legalName;
        this.email = parsedData.email;
        this.phone = parsedData.phone;
        this.name = parsedData.name;

        // Set the current step based on the retrieved data
        if (
            this.naturalPerson &&
            this.enterpriseNumber &&
            this.legalName &&
            this.nacebelCodes &&
            this.annualRevenue&&
            this.email &&
            this.phone &&
            this.name
        )
        {
          this.currentStep = 5; // Show the summary step if all data is available
        } else if (this.nacebelCodes && this.name && this.email && this.phone && this.legalName && this.annualRevenue && this.enterpriseNumber) {
          this.currentStep = 4; // Show the coverage needs step if business type and industry are selected
        } else if (this.nacebelCodes) {
          this.currentStep = 3; // Show the coverage needs step if business type and industry are selected
        } else if (this.annualRevenue) {
          this.currentStep = 2; // Show the industry step if business type is selected
        } else {
          this.currentStep = 1; // Show the first step if no data is available
        }
      }
    },
    computed: {
      isFormSaved() {
        return (
            this.naturalPerson &&
            this.enterpriseNumber &&
            this.legalName &&
            this.nacebelCodes &&
            this.annualRevenue&&
            this.email &&
            this.phone &&
            this.name
        );
      },
      isEnterpriseNumberValid(){
        const regex = /^0\d{9}$/; // Regular expression to match the required format

        // Return true if the enterpriseNumber matches the required format, otherwise false
        return regex.test(this.enterpriseNumber);
      }
    },
    methods: {
      nextStep() {
        this.currentStep++;
      },
      getAdviceTitle(advice) {
        // Extract the advice title from the HTML string
        const titleRegex = /<h3>(.*?)<\/h3>/;
        const matches = advice.match(titleRegex);
        return matches ? matches[1] : "";
      },
      getAdviceContent(advice) {
        // Remove the advice title from the HTML string
        const titleRegex = /<h3>.*?<\/h3>/;
        return advice.replace(titleRegex, "");
      },
      submitForm() {
        // Save form data to localStorage
        localStorage.setItem(
          'quoteFormData',
          JSON.stringify({
            naturalPerson: this.naturalPerson,
            enterpriseNumber: this.enterpriseNumber,
            legalName: this.legalName,
            nacebelCodes: this.nacebelCodes,
            annualRevenue: this.annualRevenue,
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
        this.naturalPerson = '',
        this.enterpriseNumber= '',
        this.legalName= '',
        this.nacebelCodes = '';
        this.annualRevenue = '';
        this.deductible = '';
        this.email = '';
        this.phone = '';
        this.name = '';
        this.currentStep = 1;
      },
      async subscribe() {

        const headers = {
            'Content-Type': 'application/json'
        };
        //check environment
        if (process.env.NODE_ENV === 'development') {
            this.url = 'http://localhost:3000/api/v1/new-requested-quote';
        }else
        {
          this.url = 'https://mybrokerservice-ijciww6s2q-ew.a.run.app/api/v1/new-requested-quote';
        }
        axios.post(this.url, {
            subscriber: {
                    email: this.email,
                    phone: this.phone,
                    name: this.name,
                },
                natural_person: this.naturalPerson,
                nacebel_codes: this.nacebelCodes,
                annual_revenue: this.annualRevenue,
                enterprise_number: this.enterpriseNumber,
                legal_name: this.legalName
                //deductible: this.deductible,
                //coverage_period: this.selectedCoveragePeriod,

         }, { headers })
            .then(result => {
            console.log(result, 'Subscribed successfully!');
              this.success = result.success;
              this.message = result.message;
              this.result = JSON.parse(result.data.quote.response);
              console.log(this.result.data.deductible)
              this.showModal = true;
              this.showResults = true;
            })
            .catch(error => {
            console.error('Error subscribing:', error);
            });
      },
      getCovers(){
        //check environment
        if (process.env.NODE_ENV === 'development') {
          this.url = 'http://localhost:3000/api/v1/nacebels';
        }else
        {
          this.url = 'https://mybrokerservice-ijciww6s2q-ew.a.run.app/api/v1/nacebels';
        }
        axios.get(this.url)
        .then(response => {
          if (response.data.length > 0) {
            this.covers = response.data
          }
          else
          {
            this.covers = nacebels.map(nacebel => {
              return {
                data: {
                  id: nacebel.id,
                  level_nr: nacebel.level_nr,
                  code: nacebel.code,
                  parent_code: nacebel.parent_code,
                  label_nl: nacebel.label_nl,
                  label_fr: nacebel.label_fr,
                  label_de: nacebel.label_de,
                  label_en: nacebel.label_en,
                  created_at: nacebel.created_at,
                  updated_at: nacebel.updated_at,
                }
              };
            });
            // Access the individual objects in the array
          }
          console.log(this.covers);
        })
        .catch(error => {
          console.log(error);
        });
        return this.covers;
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
  #summary {
    //margin-top: 100px;
  }
  </style>
