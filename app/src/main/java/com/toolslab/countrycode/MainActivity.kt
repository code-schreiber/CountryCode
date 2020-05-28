package com.toolslab.countrycode

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.os.ConfigurationCompat
import com.toolslab.countrycode.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.countryCodeTextView.text = getCountryCode()
    }

    private fun getCountryCode(): String {
        val locales = ConfigurationCompat.getLocales(resources.configuration)
        require(!locales.isEmpty) { "No locales found!" }
        return locales[0].country
    }
}
